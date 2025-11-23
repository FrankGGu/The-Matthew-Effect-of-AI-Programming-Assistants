#include <iostream>
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

            shop_prices[shop][movie] = price;
            available_movies[movie].insert({price, shop});
            rented_movies[movie][shop] = false;
        }
    }

    vector<int> search(int movie) {
        vector<int> result;
        int count = 0;
        for (auto& p : available_movies[movie]) {
            result.push_back(p.second);
            count++;
            if (count == 5) break;
        }
        return result;
    }

    void rent(int shop, int movie) {
        int price = shop_prices[shop][movie];
        available_movies[movie].erase({price, shop});
        rented_movies[movie][shop] = true;
        rented.insert({price, shop, movie});
    }

    void drop(int shop, int movie) {
        int price = shop_prices[shop][movie];
        available_movies[movie].insert({price, shop});
        rented_movies[movie][shop] = false;
        rented.erase({price, shop, movie});
    }

    vector<vector<int>> report() {
        vector<vector<int>> result;
        int count = 0;
        for (auto& r : rented) {
            result.push_back({r.second, r.third});
            count++;
            if (count == 5) break;
        }
        return result;
    }

private:
    map<int, map<int, int>> shop_prices;
    map<int, set<pair<int, int>>> available_movies;
    map<int, map<int, bool>> rented_movies;

    struct RentEntry {
        int price;
        int shop;
        int movie;

        bool operator<(const RentEntry& other) const {
            if (price != other.price) {
                return price < other.price;
            } else if (shop != other.shop) {
                return shop < other.shop;
            } else {
                return movie < other.movie;
            }
        }
    };

    set<RentEntry> rented;
};