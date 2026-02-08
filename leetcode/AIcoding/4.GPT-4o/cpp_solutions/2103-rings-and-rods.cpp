#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

int countPoints(string rings) {
    unordered_map<char, int> rodColors;
    for (int i = 0; i < rings.length(); i += 2) {
        char color = rings[i];
        char rod = rings[i + 1];
        rodColors[rod] |= (1 << (color - 'A'));
    }

    int count = 0;
    for (const auto& entry : rodColors) {
        if (entry.second == 0b111) {
            count++;
        }
    }

    return count;
}