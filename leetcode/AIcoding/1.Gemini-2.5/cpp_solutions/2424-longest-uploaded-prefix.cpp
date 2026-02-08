#include <vector>

class LUPrefix {
private:
    std::vector<bool> uploaded;
    int currentLongestPrefix;
    int totalVideos;

public:
    LUPrefix(int n) {
        totalVideos = n;
        uploaded.resize(n + 1, false);
        currentLongestPrefix = 0;
    }

    void upload(int video) {
        uploaded[video] = true;
        while (currentLongestPrefix + 1 <= totalVideos && uploaded[currentLongestPrefix + 1]) {
            currentLongestPrefix++;
        }
    }

    int longest() {
        return currentLongestPrefix;
    }
};