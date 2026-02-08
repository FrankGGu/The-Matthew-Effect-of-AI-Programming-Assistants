import java.util.Arrays;
import java.util.Comparator;

class Solution {
    class Car {
        int position;
        double timeToTarget;

        Car(int position, double timeToTarget) {
            this.position = position;
            this.timeToTarget = timeToTarget;
        }
    }

    public int carFleet(int target, int[] position, int[] speed) {
        int n = position.length;
        if (n == 0) {
            return 0;
        }

        Car[] cars = new Car[n];
        for (int i = 0; i < n; i++) {
            cars[i] = new Car(position[i], (double)(target - position[i]) / speed[i]);
        }

        Arrays.sort(cars, new Comparator<Car>() {
            @Override
            public int compare(Car a, Car b) {
                return Integer.compare(b.position, a.position);
            }
        });

        int fleets = 0;
        double currentTimeToTarget = 0.0; 

        for (Car car : cars) {
            if (car.timeToTarget > currentTimeToTarget) {
                fleets++;
                currentTimeToTarget = car.timeToTarget;
            }
        }

        return fleets;
    }
}