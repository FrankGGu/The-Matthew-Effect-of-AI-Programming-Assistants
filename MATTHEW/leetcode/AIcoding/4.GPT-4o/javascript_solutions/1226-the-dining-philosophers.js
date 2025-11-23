class DiningPhilosophers {
    constructor() {
        this.lock = new Array(5).fill().map(() => new Lock());
    }

    eat(philosopher, pickLeft, pickRight) {
        const left = this.lock[pickLeft];
        const right = this.lock[pickRight];

        left.lock();
        right.lock();

        // Philosopher is eating
        this.lock[pickLeft].unlock();
        this.lock[pickRight].unlock();
    }
}

class Lock {
    constructor() {
        this.isLocked = false;
    }

    lock() {
        while (this.isLocked) {}
        this.isLocked = true;
    }

    unlock() {
        this.isLocked = false;
    }
}

const diningPhilosophers = new DiningPhilosophers();
const philosophers = [
    () => diningPhilosophers.eat(0, 0, 1),
    () => diningPhilosophers.eat(1, 1, 2),
    () => diningPhilosophers.eat(2, 2, 3),
    () => diningPhilosophers.eat(3, 3, 4),
    () => diningPhilosophers.eat(4, 4, 0),
];