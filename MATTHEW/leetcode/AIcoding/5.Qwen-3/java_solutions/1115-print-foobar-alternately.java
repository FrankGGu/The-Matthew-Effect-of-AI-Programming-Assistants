public class Solution {

import java.util.concurrent.atomic.AtomicInteger;

public class FooBar {
    private int n;
    private AtomicInteger turn = new AtomicInteger(0);

    public FooBar(int n) {
        this.n = n;
    }

    public void foo(Runnable printFoo) throws InterruptedException {
        for (int i = 0; i < n; i++) {
            while (turn.get() != 0) {
                Thread.yield();
            }
            printFoo.run();
            turn.set(1);
        }
    }

    public void bar(Runnable printBar) throws InterruptedException {
        for (int i = 0; i < n; i++) {
            while (turn.get() != 1) {
                Thread.yield();
            }
            printBar.run();
            turn.set(0);
        }
    }
}
}