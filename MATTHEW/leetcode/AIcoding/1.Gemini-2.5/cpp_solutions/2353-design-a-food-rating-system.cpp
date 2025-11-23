#include <string>
#include <vector>
#include <set>
#include <unordered_map>

class FoodRatings {
private:
    std::unordered_map<std::string, std::pair<std::string, int>> foodDetails;
    std::unordered_map<std::string, std::set<std::pair<int, std::string>>> cuisineToRatings;

public:
    FoodRatings(std::vector<std::string>& foods, std::vector<std::string>& cuisines, std::vector<int>& ratings) {
        for (int i = 0; i < foods.size(); ++i) {
            foodDetails[foods[i]] = {cuisines[i], ratings[i]};
            cuisineToRatings[cuisines[i]].insert({-ratings[i], foods[i]});
        }
    }

    void changeRating(std::string food, int newRating) {
        std::string cuisine = foodDetails[food].first;
        int oldRating = foodDetails[food].second;

        cuisineToRatings[cuisine].erase({-oldRating, food});

        foodDetails[food].second = newRating;

        cuisineToRatings[cuisine].insert({-newRating, food});
    }

    std::string highestRated(std::string cuisine) {
        return cuisineToRatings[cuisine].begin()->second;
    }
};