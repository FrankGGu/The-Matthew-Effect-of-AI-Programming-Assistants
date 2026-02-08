import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Stack;

class Solution {
    static class Robot {
        int id;
        int position;
        int health;
        char direction;

        Robot(int id, int position, int health, char direction) {
            this.id = id;
            this.position = position;
            this.health = health;
            this.direction = direction;
        }
    }

    public List<Integer> survivedRobotsHealths(int[] positions, int[] healths, String directions) {
        int n = positions.length;
        List<Robot> robots = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            robots.add(new Robot(i, positions[i], healths[i], directions.charAt(i)));
        }

        Collections.sort(robots, (a, b) -> Integer.compare(a.position, b.position));

        Stack<Robot> stack = new Stack<>();

        for (Robot currentRobot : robots) {
            if (currentRobot.direction == 'R') {
                stack.push(currentRobot);
            } else { // currentRobot.direction == 'L'
                boolean currentRobotEliminated = false;
                while (!stack.isEmpty() && stack.peek().direction == 'R') {
                    Robot topRobot = stack.peek();

                    if (topRobot.health == currentRobot.health) {
                        stack.pop(); // Both robots are eliminated
                        currentRobotEliminated = true;
                        break;
                    } else if (topRobot.health > currentRobot.health) {
                        topRobot.health--; // Top robot loses 1 health
                        currentRobotEliminated = true;
                        break;
                    } else { // topRobot.health < currentRobot.health
                        stack.pop(); // Top robot is eliminated
                        currentRobot.health--; // Current robot loses 1 health
                        // Continue the loop, currentRobot might collide with the next robot on the stack
                    }
                }
                if (!currentRobotEliminated) {
                    stack.push(currentRobot); // This 'L' robot survived all collisions with 'R' robots to its left, or found no 'R' robots.
                }
            }
        }

        List<Robot> survivors = new ArrayList<>(stack);
        Collections.sort(survivors, (a, b) -> Integer.compare(a.id, b.id));

        List<Integer> result = new ArrayList<>();
        for (Robot robot : survivors) {
            result.add(robot.health);
        }

        return result;
    }
}