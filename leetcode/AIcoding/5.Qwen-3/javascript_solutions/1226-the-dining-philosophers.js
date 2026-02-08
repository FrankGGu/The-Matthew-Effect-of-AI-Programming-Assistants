function DiningPhilosophers() {
    const forks = [new Semaphore(1), new Semaphore(1), new Semaphore(1), new Semaphore(1), new Semaphore(1)];

    this wantsToEat = async (philosopher, pickLeftFork, pickRightFork, eat, putLeftFork, putRightFork) => {
        while (true) {
            await pickLeftFork();
            await pickRightFork();
            eat();
            putLeftFork();
            putRightFork();
            break;
        }
    };
}

class Semaphore {
    constructor(initialValue) {
        this.value = initialValue;
        this.waiting = [];
    }

    acquire() {
        return new Promise(resolve => {
            if (this.value > 0) {
                this.value--;
                resolve();
            } else {
                this.waiting.push(resolve);
            }
        });
    }

    release() {
        if (this.waiting.length > 0) {
            const next = this.waiting.shift();
            next();
        } else {
            this.value++;
        }
    }
}