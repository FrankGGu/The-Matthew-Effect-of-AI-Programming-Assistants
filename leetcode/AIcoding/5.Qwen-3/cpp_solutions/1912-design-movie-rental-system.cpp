#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    Solution(vector<int>& movies) {
        for (int movie : movies) {
            availableMovies[movie].insert(0);
        }
    }

    vector<int> search(int movie) {
        vector<int> result;
        if (availableMovies.find(movie) == availableMovies.end()) {
            return result;
        }
        for (int shop : availableMovies[movie]) {
            result.push_back(shop);
        }
        sort(result.begin(), result.end());
        return result;
    }

    void rent(int shop, int movie) {
        if (availableMovies[movie].find(shop) != availableMovies[movie].end()) {
            availableMovies[movie].erase(shop);
            rentedMovies[movie].insert(shop);
        }
    }

    void drop(int shop, int movie) {
        if (rentedMovies[movie].find(shop) != rentedMovies[movie].end()) {
            rentedMovies[movie].erase(shop);
            availableMovies[movie].insert(shop);
        }
    }

    vector<vector<int>> report() {
        vector<vector<int>> result;
        for (auto it = rentedMovies.begin(); it != rentedMovies.end(); ++it) {
            for (int shop : it->second) {
                result.push_back({it->first, shop});
            }
        }
        sort(result.begin(), result.end());
        return result;
    }

private:
    map<int, set<int>> availableMovies;
    map<int, set<int>> rentedMovies;
};