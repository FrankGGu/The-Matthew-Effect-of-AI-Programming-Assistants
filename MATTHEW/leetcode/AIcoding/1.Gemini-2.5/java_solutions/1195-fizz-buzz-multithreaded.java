import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;
import java.util.function.IntConsumer;

class FizzBuzz {
    private int n;
    private volatile int currentNumber = 1;
    private final ReentrantLock lock = new ReentrantLock();
    private final Condition condition = lock.newCondition();

    public FizzBuzz(int n) {
        this.n = n;
    }

    // printFizz.run() outputs "fizz".
    public void fizz(Runnable printFizz) throws InterruptedException {
        lock.lock();
        try {
            while (currentNumber <= n) {
                if (currentNumber % 3 == 0 && currentNumber % 5 != 0) {
                    printFizz.run();
                    currentNumber++;
                    condition.signalAll();
                } else {
                    condition.await();
                }
            }
        } finally {
            lock.unlock();
        }
    }

    // printBuzz.run() outputs "buzz".
    public void buzz(Runnable printBuzz) throws InterruptedException {
        lock.lock();
        try {
            while (currentNumber <= n) {
                if (currentNumber % 5 == 0 && currentNumber % 3 != 0) {
                    printBuzz.run();
                    currentNumber++;
                    condition.signalAll();
                } else {
                    condition.await();
                }
            }
        } finally {
            lock.unlock();
        }
    }

    // printFizzBuzz.run() outputs "fizzbuzz".
    public void fizzbuzz(Runnable printFizzBuzz) throws InterruptedException {
        lock.lock();
        try {
            while (currentNumber <= n) {
                if (currentNumber % 15 == 0) {
                    printFizzBuzz.run();
                    currentNumber++;
                    condition.signalAll();
                } else {
                    condition.await();
                }
            }
        } finally {
            lock.unlock();
        }
    }

    // printNumber.accept(x) outputs "x", where x is an integer.
    public void number(IntConsumer printNumber) throws InterruptedException {
        lock.lock();
        try {
            while (currentNumber <= n) {
                if (currentNumber % 3 != 0 && currentNumber % 5 != 0) {
                    printNumber.accept(currentNumber);
                    currentNumber++;
                    condition.signalAll();
                } else {
                    condition.await();
                }
            }
        } finally {
            // Ensure all threads are woken up and can exit if n is reached
            // even if they were waiting for a specific condition that won't be met again.
            condition.signalAll(); 
            lock.unlock();
        }
    }
}