class TrafficLight {
    constructor() {
        this.greenA = true;
        this.lock = new Mutex();
    }

    async carArrived(carId, roadId, direction, turnGreen, crossCar) {
        await this.lock.acquire();
        if ((roadId === 1 && !this.greenA) || (roadId === 2 && this.greenA)) {
            await turnGreen();
            this.greenA = !this.greenA;
        }
        await crossCar();
        this.lock.release();
    }
}

class Mutex {
    constructor() {
        this.locked = false;
        this.queue = [];
    }

    acquire() {
        return new Promise((resolve) => {
            if (!this.locked) {
                this.locked = true;
                resolve();
            } else {
                this.queue.push(resolve);
            }
        });
    }

    release() {
        if (this.queue.length > 0) {
            const nextResolve = this.queue.shift();
            nextResolve();
        } else {
            this.locked = false;
        }
    }
}