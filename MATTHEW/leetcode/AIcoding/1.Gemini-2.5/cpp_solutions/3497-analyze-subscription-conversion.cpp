#include <vector>
#include <string>
#include <map>
#include <iomanip>
#include <cmath>

struct Activity {
    int activity_id;
    int user_id;
    std::string activity_type;
    std::string time_stamp;
};

class Solution {
public:
    double analyzeSubscriptionConversion(std::vector<Activity>& activities) {
        std::map<int, std::pair<bool, bool>> user_status;

        for (const auto& activity : activities) {
            int year = std::stoi(activity.time_stamp.substr(0, 4));
            if (year != 2021) {
                continue;
            }

            if (activity.activity_type == "signup") {
                user_status[activity.user_id].first = true;
            } else if (activity.activity_type == "start") {
                user_status[activity.user_id].second = true;
            }
        }

        int total_signups_2021 = 0;
        int converted_users_2021 = 0;

        for (const auto& entry : user_status) {
            bool signed_up = entry.second.first;
            bool started_subscription = entry.second.second;

            if (signed_up) {
                total_signups_2021++;
                if (started_subscription) {
                    converted_users_2021++;
                }
            }
        }

        if (total_signups_2021 == 0) {
            return 0.00;
        }

        double conversion_rate = static_cast<double>(converted_users_2021) / total_signups_2021 * 100.0;

        return std::round(conversion_rate * 100.0) / 100.0;
    }
};