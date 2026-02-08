class TrafficLight {
    private int currentGreenRoadPair = 0; // 0: no one, 1: (1,3) roads, 2: (2,4) roads
    private int carsCrossingCount = 0;
    private final Object lock = new Object();

    public TrafficLight() {
    }

    public void carArrived(int carId, int roadId, int turnDirection,
                           Runnable turnGreen, Runnable crossCar) {
        int targetRoadPair = (roadId == 1 || roadId == 3) ? 1 : 2;

        synchronized (lock) {
            while (currentGreenRoadPair != 0 && currentGreenRoadPair != targetRoadPair) {
                try {
                    lock.wait();
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    return;
                }
            }

            if (currentGreenRoadPair == 0) {
                currentGreenRoadPair = targetRoadPair;
                turnGreen.run();
            }

            carsCrossingCount++;
        }

        crossCar.run();

        synchronized (lock) {
            carsCrossingCount--;
            if (carsCrossingCount == 0) {
                currentGreenRoadPair = 0;
                lock.notifyAll();
            }
        }
    }
}