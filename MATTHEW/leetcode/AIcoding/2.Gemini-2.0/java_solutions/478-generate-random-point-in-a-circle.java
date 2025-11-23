import java.util.Random;

class Solution {

    private double radius;
    private double x_center;
    private double y_center;
    private Random random;

    public Solution(double radius, double x_center, double y_center) {
        this.radius = radius;
        this.x_center = x_center;
        this.y_center = y_center;
        this.random = new Random();
    }

    public double[] randPoint() {
        double x, y;
        do {
            x = random.nextDouble() * 2 * radius - radius;
            y = random.nextDouble() * 2 * radius - radius;
        } while (x * x + y * y > radius * radius);

        return new double[]{x + x_center, y + y_center};
    }
}