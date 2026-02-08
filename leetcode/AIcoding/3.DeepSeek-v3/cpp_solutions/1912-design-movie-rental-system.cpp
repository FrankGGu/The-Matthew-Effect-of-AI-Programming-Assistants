#include <vector>
#include <unordered_map>
#include <set>
#include <climits>

using namespace std;

class MovieRentingSystem {
private:
    struct Entry {
        int shop;
        int movie;
        int price;
        bool operator<(const Entry& other) const {
            if (price != other.price) return price < other.price;
            if (shop != other.shop) return shop < other.shop;
            return movie < other.movie;
        }
    };

    unordered_map<int, set<Entry>> unrented;
    unordered_map<int, unordered_map<int, int>> prices;
    set<Entry> rented;

public:
    MovieRentingSystem(int n, vector<vector<int>>& entries) {
        for (const auto& entry : entries) {
            int shop = entry[0];
            int movie = entry[1];
            int price = entry[2];
            unrented[movie].insert({shop, movie, price});
            prices[shop][movie] = price;
        }
    }

    vector<int> search(int movie) {
        vector<int> result;
        if (unrented.find(movie) == unrented.end()) return result;
        auto& entries = unrented[movie];
        for (const auto& entry : entries) {
            result.push_back(entry.shop);
            if (result.size() == 5) break;
        }
        return result;
    }

    void rent(int shop, int movie) {
        int price = prices[shop][movie];
        unrented[movie].erase({shop, movie, price});
        rented.insert({shop, movie, price});
    }

    void drop(int shop, int movie) {
        int price = prices[shop][movie];
        rented.erase({shop, movie, price});
        unrented[movie].insert({shop, movie, price});
    }

    vector<vector<int>> report() {
        vector<vector<int>> result;
        for (const auto& entry : rented) {
            result.push_back({entry.shop, entry.movie});
            if (result.size() == 5) break;
        }
        return result;
    }
};