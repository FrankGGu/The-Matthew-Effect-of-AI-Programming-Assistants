#include <vector>
#include <stack>
#include <algorithm>

struct Robot {
    int id;
    int position;
    int health;
    char direction;

    Robot(int i, int p, int h, char d) : id(i), position(p), health(h), direction(d) {}
};

bool compareRobots(const Robot& a, const Robot& b) {
    return a.position < b.position;
}

class Solution {
public:
    std::vector<int> survivedRobotsHealths(std::vector<int>& positions, std::vector<int>& healths, std::string directions) {
        int n = positions.size();
        std::vector<Robot> robots;
        for (int i = 0; i < n; ++i) {
            robots.emplace_back(i, positions[i], healths[i], directions[i]);
        }

        std::sort(robots.begin(), robots.end(), compareRobots);

        std::stack<Robot> st;
        for (Robot& current_robot : robots) {
            if (current_robot.direction == 'R') {
                st.push(current_robot);
            } else {
                bool current_robot_destroyed = false;
                while (!st.empty() && st.top().direction == 'R') {
                    Robot& top_robot = st.top();

                    if (current_robot.health > top_robot.health) {
                        current_robot.health--;
                        st.pop();
                    } else if (current_robot.health < top_robot.health) {
                        top_robot.health--;
                        current_robot_destroyed = true;
                        break;
                    } else {
                        st.pop();
                        current_robot_destroyed = true;
                        break;
                    }
                }
                if (!current_robot_destroyed) {
                    st.push(current_robot);
                }
            }
        }

        std::vector<Robot> survivors;
        while (!st.empty()) {
            survivors.push_back(st.top());
            st.pop();
        }

        std::sort(survivors.begin(), survivors.end(), [](const Robot& a, const Robot& b) {
            return a.id < b.id;
        });

        std::vector<int> result_healths;
        for (const Robot& r : survivors) {
            result_healths.push_back(r.health);
        }

        return result_healths;
    }
};