#include <vector>
#include <string>
#include <utility>

class Robot {
private:
    int W, H;
    std::vector<std::pair<int, int>> perimeter_coords;
    std::vector<std::string> perimeter_dirs_str;
    int P; 
    int current_idx; 

public:
    Robot(int width, int height) {
        W = width;
        H = height;

        if (W == 1 && H == 1) {
            perimeter_coords.push_back({0, 0});
            perimeter_dirs_str.push_back("East");
            P = 1;
            current_idx = 0;
            return;
        }

        for (int x = 0; x < W; ++x) {
            perimeter_coords.push_back({x, 0});
        }
        for (int y = 1; y < H; ++y) {
            perimeter_coords.push_back({W - 1, y});
        }
        for (int x = W - 2; x >= 0; --x) {
            perimeter_coords.push_back({x, H - 1});
        }
        for (int y = H - 2; y >= 1; --y) {
            perimeter_coords.push_back({0, y});
        }

        P = perimeter_coords.size();

        for (int i = 0; i < P; ++i) {
            std::pair<int, int> current_pos = perimeter_coords[i];
            std::pair<int, int> next_pos = perimeter_coords[(i + 1) % P];

            if (next_pos.first > current_pos.first) {
                perimeter_dirs_str.push_back("East");
            } else if (next_pos.first < current_pos.first) {
                perimeter_dirs_str.push_back("West");
            } else if (next_pos.second > current_pos.second) {
                perimeter_dirs_str.push_back("North");
            } else {
                perimeter_dirs_str.push_back("South");
            }
        }

        current_idx = 0;
    }

    void step(int num) {
        current_idx = (current_idx + num) % P;
    }

    std::vector<int> getPos() {
        return {perimeter_coords[current_idx].first, perimeter_coords[current_idx].second};
    }

    std::string getDir() {
        return perimeter_dirs_str[current_idx];
    }
};