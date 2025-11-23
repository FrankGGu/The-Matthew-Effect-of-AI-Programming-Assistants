class DiningPhilosophers {
    constructor() {
        this.forks = Array(5).fill(0).map(() => new Semaphore(1));
        this.room = new Semaphore(4);
    }

    async wantsToEat(philosopher, eat, putLeftFork, putRightFork, pickLeftFork, pickRightFork) {
        await this.room.acquire();
        await this.forks[philosopher].acquire();
        await this.forks[(philosopher + 1) % 5].acquire();

        await pickLeftFork();
        await pickRightFork();
        await eat();
        await putLeftFork();
        await putRightFork();

        this.forks[philosopher].release();
        this.forks[(philosopher + 1) % 5].release();
        this.room.release();
    }
}

class Semaphore {
    constructor(capacity) {
        this.capacity = capacity;
        this.queue = [];
    }

    acquire() {
        return new Promise((resolve) => {
            if (this.capacity > 0) {
                this.capacity--;
                resolve();
            } else {
                this.queue.push(resolve);
            }
        });
    }

    release() {
        if (this.queue.length > 0) {
            const resolve = this.queue.shift();
            resolve();
        } else {
            this.capacity++;
        }
    }
}