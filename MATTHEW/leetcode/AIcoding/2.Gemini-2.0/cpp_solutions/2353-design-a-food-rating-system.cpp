#include <string>
#include <vector>
#include <map>
#include <set>

using namespace std;

class FoodRatings {
public:
    map<string, string> food_cuisine;
    map<string, int> food_rating;
    map<string, set<pair<int, string>>> cuisine_foods;

    FoodRatings(vector<string>& foods, vector<string>& cuisines, vector<int>& ratings) {
        for (int i = 0; i < foods.size(); ++i) {
            food_cuisine[foods[i]] = cuisines[i];
            food_rating[foods[i]] = ratings[i];
            cuisine_foods[cuisines[i]].insert({-ratings[i], foods[i]});
        }
    }

    void changeRating(string food, int newRating) {
        string cuisine = food_cuisine[food];
        cuisine_foods[cuisine].erase({-food_rating[food], food});
        food_rating[food] = newRating;
        cuisine_foods[cuisine].insert({-newRating, food});
    }

    string highestRated(string cuisine) {
        return cuisine_foods[cuisine].begin()->second;
    }
};