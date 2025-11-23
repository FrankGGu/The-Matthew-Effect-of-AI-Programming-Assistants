#include <vector>
#include <string>
#include <unordered_map>
#include <set>
using namespace std;

class FoodRatings {
private:
    struct FoodInfo {
        string cuisine;
        int rating;
    };
    unordered_map<string, FoodInfo> foodMap;
    unordered_map<string, set<pair<int, string>>> cuisineMap;

public:
    FoodRatings(vector<string>& foods, vector<string>& cuisines, vector<int>& ratings) {
        for (int i = 0; i < foods.size(); ++i) {
            string food = foods[i];
            string cuisine = cuisines[i];
            int rating = ratings[i];
            foodMap[food] = {cuisine, rating};
            cuisineMap[cuisine].insert({-rating, food});
        }
    }

    void changeRating(string food, int newRating) {
        auto& info = foodMap[food];
        string cuisine = info.cuisine;
        int oldRating = info.rating;
        cuisineMap[cuisine].erase({-oldRating, food});
        cuisineMap[cuisine].insert({-newRating, food});
        info.rating = newRating;
    }

    string highestRated(string cuisine) {
        return cuisineMap[cuisine].begin()->second;
    }
};