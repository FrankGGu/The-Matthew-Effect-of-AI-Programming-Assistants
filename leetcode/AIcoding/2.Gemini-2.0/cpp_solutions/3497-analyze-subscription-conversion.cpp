#include <vector>
#include <unordered_map>

using namespace std;

struct Subscription {
    int account_id;
    string start_date;
    string end_date;
    string subscription_type;
};

vector<vector<string>> analyze_subscription_conversion(vector<Subscription>& subscriptions) {
    unordered_map<int, vector<Subscription>> account_subscriptions;
    for (auto& sub : subscriptions) {
        account_subscriptions[sub.account_id].push_back(sub);
    }

    vector<vector<string>> result;
    for (auto& [account_id, subs] : account_subscriptions) {
        sort(subs.begin(), subs.end(), [](const Subscription& a, const Subscription& b) {
            return a.start_date < b.start_date;
        });

        for (size_t i = 0; i < subs.size() - 1; ++i) {
            if (subs[i].end_date == subs[i + 1].start_date) {
                result.push_back({to_string(account_id), subs[i].subscription_type, subs[i + 1].subscription_type});
            }
        }
    }

    return result;
}