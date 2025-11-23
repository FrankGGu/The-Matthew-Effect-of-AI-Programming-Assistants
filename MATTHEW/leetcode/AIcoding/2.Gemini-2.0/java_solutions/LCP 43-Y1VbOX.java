import java.util.concurrent.Semaphore;

class TrafficLight {

    private int greenRoad;
    private Semaphore semaphore;

    public TrafficLight() {
        this.greenRoad = 1;
        this.semaphore = new Semaphore(1);
    }

    public void carArrived(
            int carId,           // ID of the car
            int roadId,          // ID of the road the car travels on. Can be 1 (road A) or 2 (road B)
            int direction,       // Direction of the car which is an integer from 0 to 3. The meaning of the value is defined below.
            Runnable turnGreen,  // Use turnGreen.run() to turn light to green on current road
            Runnable crossCar    // Use crossCar.run() to make car cross the intersection
    ) throws InterruptedException {
        semaphore.acquire();
        if (roadId != greenRoad) {
            turnGreen.run();
            greenRoad = roadId;
        }
        crossCar.run();
        semaphore.release();
    }
}