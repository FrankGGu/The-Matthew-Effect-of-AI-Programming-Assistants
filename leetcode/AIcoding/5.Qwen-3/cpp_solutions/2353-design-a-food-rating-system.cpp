#include <iostream>
#include <vector>
#include <map>
#include <unordered_map>
#include <set>
#include <algorithm>

using namespace std;

class Solution {
private:
    map<string, int> foodRating;
    map<string, string> foodCuisine;
    map<string, set<string>> cuisineToFood;

public:
    Solution() {}

    void changeRating(string food, string newRating) {
        string cuisine = foodCuisine[food];
        int oldRating = foodRating[food];
        foodRating[food] = stoi(newRating);
        cuisineToFood[cuisine].erase(food);
        cuisineToFood[cuisine].insert(food);
    }

    string highestRated(string cuisine) {
        auto& foods = cuisineToFood[cuisine];
        return *foods.begin();
    }
};