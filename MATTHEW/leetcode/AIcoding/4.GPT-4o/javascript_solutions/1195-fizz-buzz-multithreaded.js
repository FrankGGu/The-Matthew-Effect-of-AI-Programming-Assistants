class FizzBuzz {
    private int n;
    private final Object lock = new Object();
    private int count = 1;

    public FizzBuzz(int n) {
        this.n = n;
    }

    public void fizz(Runnable printFizz) throws InterruptedException {
        while (true) {
            synchronized (lock) {
                if (count > n) return;
                if (count % 3 == 0 && count % 5 != 0) {
                    printFizz.run();
                    count++;
                    lock.notifyAll();
                } else {
                    lock.wait();
                }
            }
        }
    }

    public void buzz(Runnable printBuzz) throws InterruptedException {
        while (true) {
            synchronized (lock) {
                if (count > n) return;
                if (count % 5 == 0 && count % 3 != 0) {
                    printBuzz.run();
                    count++;
                    lock.notifyAll();
                } else {
                    lock.wait();
                }
            }
        }
    }

    public void fizzbuzz(Runnable printFizzBuzz) throws InterruptedException {
        while (true) {
            synchronized (lock) {
                if (count > n) return;
                if (count % 15 == 0) {
                    printFizzBuzz.run();
                    count++;
                    lock.notifyAll();
                } else {
                    lock.wait();
                }
            }
        }
    }

    public void number(IntConsumer printNumber) throws InterruptedException {
        while (true) {
            synchronized (lock) {
                if (count > n) return;
                if (count % 3 != 0 && count % 5 != 0) {
                    printNumber.accept(count);
                    count++;
                    lock.notifyAll();
                } else {
                    lock.wait();
                }
            }
        }
    }
}