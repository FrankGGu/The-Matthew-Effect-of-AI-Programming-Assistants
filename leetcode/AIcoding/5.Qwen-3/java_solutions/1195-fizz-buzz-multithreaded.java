public class Solution {

import java.util.concurrent.atomic.AtomicInteger;

public class FizzBuzz {
    private int n;
    private AtomicInteger count = new AtomicInteger(1);

    public FizzBuzz(int n) {
        this.n = n;
    }

    // printFizz.run() outputs "fizz".
    public void fizz(Runnable printFizz) throws InterruptedException {
        while (count.get() <= n) {
            if (count.get() % 3 == 0 && count.get() % 5 != 0) {
                printFizz.run();
                count.incrementAndGet();
            } else {
                Thread.yield();
            }
        }
    }

    // printBuzz.run() outputs "buzz".
    public void buzz(Runnable printBuzz) throws InterruptedException {
        while (count.get() <= n) {
            if (count.get() % 5 == 0 && count.get() % 3 != 0) {
                printBuzz.run();
                count.incrementAndGet();
            } else {
                Thread.yield();
            }
        }
    }

    // printFizzBuzz.run() outputs "fizzbuzz".
    public void fizzbuzz(Runnable printFizzBuzz) throws InterruptedException {
        while (count.get() <= n) {
            if (count.get() % 3 == 0 && count.get() % 5 == 0) {
                printFizzBuzz.run();
                count.incrementAndGet();
            } else {
                Thread.yield();
            }
        }
    }

    // printNumber.accept(i) outputs "i", where i is an integer.
    public void number(IntConsumer printNumber) throws InterruptedException {
        while (count.get() <= n) {
            if (count.get() % 3 != 0 && count.get() % 5 != 0) {
                printNumber.accept(count.get());
                count.incrementAndGet();
            } else {
                Thread.yield();
            }
        }
    }
}
}