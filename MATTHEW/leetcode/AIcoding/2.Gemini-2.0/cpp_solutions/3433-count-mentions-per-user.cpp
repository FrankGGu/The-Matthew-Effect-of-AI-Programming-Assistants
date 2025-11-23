#include <vector>
#include <string>
#include <sstream>
#include <unordered_map>

using namespace std;

struct Users {
    int user_id;
    string name;
};

struct Tweets {
    int tweet_id;
    int poster_id;
    string tweet;
};

vector<vector<string>> countMentions(vector<Users>& users, vector<Tweets>& tweets) {
    unordered_map<int, string> userMap;
    for (auto& user : users) {
        userMap[user.user_id] = user.name;
    }

    unordered_map<string, int> mentionCount;
    for (auto& tweet : tweets) {
        stringstream ss(tweet.tweet);
        string word;
        while (getline(ss, word, ' ')) {
            if (word.length() > 0 && word[0] == '@') {
                string mention = word.substr(1);
                mentionCount[mention]++;
            }
        }
    }

    vector<vector<string>> result;
    for (auto& pair : mentionCount) {
        result.push_back({pair.first, to_string(pair.second)});
    }

    return result;
}