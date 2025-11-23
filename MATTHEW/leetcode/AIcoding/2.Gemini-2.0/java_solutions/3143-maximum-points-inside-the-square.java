import java.util.List;

class Solution {
    public int maxPointsInsideSquare(List<List<Integer>> points, int side) {
        int maxPoints = 0;
        for (List<Integer> p1 : points) {
            for (List<Integer> p2 : points) {
                int x1 = p1.get(0);
                int y1 = p1.get(1);
                int x2 = p2.get(0);
                int y2 = p2.get(1);

                int x = Math.min(x1, x2);
                int y = Math.min(y1, y2);

                int count1 = 0;
                for (List<Integer> p : points) {
                    int px = p.get(0);
                    int py = p.get(1);
                    if (px >= x && px <= x + side && py >= y && py <= y + side) {
                        count1++;
                    }
                }
                maxPoints = Math.max(maxPoints, count1);

                x = Math.min(x1, x2);
                y = Math.max(y1, y2) - side;

                int count2 = 0;
                for (List<Integer> p : points) {
                    int px = p.get(0);
                    int py = p.get(1);
                    if (px >= x && px <= x + side && py >= y && py <= y + side) {
                        count2++;
                    }
                }
                maxPoints = Math.max(maxPoints, count2);

                x = Math.max(x1, x2) - side;
                y = Math.min(y1, y2);

                int count3 = 0;
                for (List<Integer> p : points) {
                    int px = p.get(0);
                    int py = p.get(1);
                    if (px >= x && px <= x + side && py >= y && py <= y + side) {
                        count3++;
                    }
                }
                maxPoints = Math.max(maxPoints, count3);

                x = Math.max(x1, x2) - side;
                y = Math.max(y1, y2) - side;

                int count4 = 0;
                for (List<Integer> p : points) {
                    int px = p.get(0);
                    int py = p.get(1);
                    if (px >= x && px <= x + side && py >= y && py <= y + side) {
                        count4++;
                    }
                }
                maxPoints = Math.max(maxPoints, count4);
            }
        }

        return maxPoints;
    }
}