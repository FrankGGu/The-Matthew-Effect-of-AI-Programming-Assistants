#include <vector>

using namespace std;

class Solution {
public:
    vector<int> getDirections(int height, int width, vector<int>& start, string direction, vector<vector<int>>& queries) {
        int x = start[0], y = start[1];
        int dx = 0, dy = 0;
        if (direction == "North") dx = -1;
        else if (direction == "South") dx = 1;
        else if (direction == "West") dy = -1;
        else dy = 1;

        vector<int> res;
        for (auto& query : queries) {
            int targetX = query[0], targetY = query[1];
            int steps = 0;

            while (true) {
                if (dx == -1) {
                    int dist = x;
                    int stepsTaken = dist;
                    if (x - dist + dx < 0) {
                        stepsTaken = -1;
                    }

                    if (steps + stepsTaken >= 0) {
                        if (x - dist + dx == targetX && y == targetY) {
                            steps += stepsTaken;
                            break;
                        }
                    }

                    if (x - dist + dx < 0) {
                         steps += x;
                        x = 0;
                        dx = 1;
                        dy = dy;
                    } else {
                        steps += dist;
                        x -= dist;
                        break;
                    }

                } else if (dx == 1) {
                    int dist = height - 1 - x;
                    int stepsTaken = dist;
                      if (x + dist + dx > height -1) {
                        stepsTaken = -1;
                    }
                    if (steps + stepsTaken >= 0) {
                       if (x + dist + dx == targetX && y == targetY) {
                            steps += stepsTaken;
                            break;
                        }
                    }

                    if (x + dist + dx > height - 1) {
                         steps += height - 1 - x;
                        x = height - 1;
                        dx = -1;
                        dy = dy;
                    } else {
                        steps += dist;
                        x += dist;
                        break;
                    }

                } else if (dy == -1) {
                    int dist = y;
                    int stepsTaken = dist;
                      if (y - dist + dy < 0) {
                        stepsTaken = -1;
                    }
                    if (steps + stepsTaken >= 0) {
                      if (x == targetX && y - dist + dy == targetY) {
                            steps += stepsTaken;
                            break;
                        }
                    }

                    if (y - dist + dy < 0) {
                         steps += y;
                        y = 0;
                        dy = 1;
                        dx = dx;
                    } else {
                        steps += dist;
                        y -= dist;
                        break;
                    }

                } else {
                    int dist = width - 1 - y;
                    int stepsTaken = dist;
                      if (y + dist + dy > width - 1) {
                        stepsTaken = -1;
                    }
                    if (steps + stepsTaken >= 0) {
                        if (x == targetX && y + dist + dy == targetY) {
                            steps += stepsTaken;
                            break;
                        }
                    }

                    if (y + dist + dy > width - 1) {
                        steps += width - 1 - y;
                        y = width - 1;
                        dy = -1;
                        dx = dx;
                    } else {
                        steps += dist;
                        y += dist;
                        break;
                    }
                }
            }
            res.push_back(steps);
        }
        return res;
    }
};