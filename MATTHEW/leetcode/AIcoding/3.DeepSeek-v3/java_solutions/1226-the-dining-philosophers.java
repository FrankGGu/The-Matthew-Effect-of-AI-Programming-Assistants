class DiningPhilosophers {
    private final Object[] forks = new Object[5];

    public DiningPhilosophers() {
        for (int i = 0; i < 5; i++) {
            forks[i] = new Object();
        }
    }

    public void wantsToEat(int philosopher,
                           Runnable pickLeftFork,
                           Runnable pickRightFork,
                           Runnable eat,
                           Runnable putLeftFork,
                           Runnable putRightFork) throws InterruptedException {
        int leftFork = philosopher;
        int rightFork = (philosopher + 1) % 5;

        if (philosopher % 2 == 0) {
            synchronized (forks[leftFork]) {
                synchronized (forks[rightFork]) {
                    pickLeftFork.run();
                    pickRightFork.run();
                    eat.run();
                    putRightFork.run();
                    putLeftFork.run();
                }
            }
        } else {
            synchronized (forks[rightFork]) {
                synchronized (forks[leftFork]) {
                    pickRightFork.run();
                    pickLeftFork.run();
                    eat.run();
                    putLeftFork.run();
                    putRightFork.run();
                }
            }
        }
    }
}