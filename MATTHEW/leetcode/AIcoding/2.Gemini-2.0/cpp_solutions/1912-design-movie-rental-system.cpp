#include <vector>
#include <set>
#include <map>

using namespace std;

class MovieRentingSystem {
public:
    MovieRentingSystem(int n, vector<vector<int>>& entries) {
        for (auto& entry : entries) {
            int shop = entry[0];
            int movie = entry[1];
            int price = entry[2];
            movies[movie][shop] = price;
            available.insert({price, movie, shop});
            rentedMovies[movie][shop] = false;
        }
    }

    vector<int> search(int movie) {
        vector<int> result;
        set<pair<int, int>> prices;
        for (auto& [shop, price] : movies[movie]) {
            if (!rentedMovies[movie][shop]) {
                prices.insert({price, shop});
            }
        }
        int count = 0;
        for (auto& [price, shop] : prices) {
            result.push_back(shop);
            count++;
            if (count == 5) {
                break;
            }
        }
        return result;
    }

    void rent(int shop, int movie) {
        int price = movies[movie][shop];
        available.erase({price, movie, shop});
        rented.insert({price, movie, shop});
        rentedMovies[movie][shop] = true;
    }

    void drop(int shop, int movie) {
        int price = movies[movie][shop];
        rented.erase({price, movie, shop});
        available.insert({price, movie, shop});
        rentedMovies[movie][shop] = false;
    }

    vector<vector<int>> report() {
        vector<vector<int>> result;
        int count = 0;
        for (auto& entry : rented) {
            result.push_back({entry.second, entry.third});
            count++;
            if (count == 5) {
                break;
            }
        }
        return result;
    }

private:
    map<int, map<int, int>> movies;
    set<tuple<int, int, int>> available;
    set<tuple<int, int, int>> rented;
    map<int, map<int, bool>> rentedMovies;
};