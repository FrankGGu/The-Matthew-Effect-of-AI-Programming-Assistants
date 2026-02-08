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
        double angle = 2 * Math.PI * random.nextDouble();
        double r = radius * Math.sqrt(random.nextDouble());
        double x = x_center + r * Math.cos(angle);
        double y = y_center + r * Math.sin(angle);
        return new double[]{x, y};
    }
}