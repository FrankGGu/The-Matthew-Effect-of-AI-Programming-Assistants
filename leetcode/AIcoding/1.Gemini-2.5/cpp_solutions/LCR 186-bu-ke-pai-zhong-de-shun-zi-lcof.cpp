#include <vector>
#include <string>
#include <algorithm>

class Solution {
private:
    struct Dynasty {
        std::string name;
        int start;
        int end;
    };
    static const std::vector<Dynasty> dynasties;

public:
    std::vector<std::string> identifyDynasty(std::vector<std::vector<int>>& places) {
        std::vector<std::string> ans;
        ans.reserve(places.size());

        for (const auto& place : places) {
            int year = place[0];
            int attribute = place[1];

            std::vector<const Dynasty*> matches;
            for (const auto& d : dynasties) {
                if (year >= d.start && year <= d.end) {
                    matches.push_back(&d);
                }
            }

            if (matches.empty()) {
                ans.push_back("");
            } else if (matches.size() == 1) {
                ans.push_back(matches[0]->name);
            } else {
                if (matches[0]->start > matches[1]->start) {
                    std::swap(matches[0], matches[1]);
                }

                if (attribute == 0) {
                    ans.push_back(matches[0]->name);
                } else {
                    ans.push_back(matches[1]->name);
                }
            }
        }

        return ans;
    }
};

const std::vector<Solution::Dynasty> Solution::dynasties = {
    {"Tang", 618, 907},
    {"Song", 960, 1279},
    {"Yuan", 1271, 1368},
    {"Ming", 1368, 1644},
    {"Qing", 1644, 1912}
};