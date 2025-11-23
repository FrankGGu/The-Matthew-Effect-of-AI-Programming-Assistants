class TrafficSystem {
    constructor() {
        this.count = 0;
        this.currentLight = 'red';
    }

    toggleLight() {
        this.currentLight = this.currentLight === 'red' ? 'green' : 'red';
        this.count++;
    }

    getCurrentLight() {
        return this.currentLight;
    }

    getCount() {
        return this.count;
    }
}