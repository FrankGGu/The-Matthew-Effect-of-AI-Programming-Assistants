#include <unordered_map>
#include <set>
#include <string>

class FoodRatings {
public:
    FoodRatings(vector<string>& foods, vector<string>& cuisines, vector<int>& ratings) {
        for (int i = 0; i < foods.size(); ++i) {
            foodRating[foods[i]] = ratings[i];
            cuisineMap[cuisines[i]].insert({ratings[i], foods[i]});
        }
    }

    void changeRating(string food, int newRating) {
        string cuisine;
        for (const auto& [c, foods] : cuisineMap) {
            auto it = foods.find({foodRating[food], food});
            if (it != foods.end()) {
                cuisine = c;
                foods.erase(it);
                break;
            }
        }
        foodRating[food] = newRating;
        cuisineMap[cuisine].insert({newRating, food});
    }

    string highestRated(string cuisine) {
        return (*cuisineMap[cuisine].rbegin()).second;
    }

private:
    unordered_map<string, int> foodRating;
    unordered_map<string, set<pair<int, string>>> cuisineMap;
};