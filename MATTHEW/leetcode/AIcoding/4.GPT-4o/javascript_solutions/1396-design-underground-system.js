class UndergroundSystem {
    constructor() {
        this.checkIns = new Map();
        this.travelTimes = new Map();
    }

    checkIn(id, stationName, t) {
        this.checkIns.set(id, [stationName, t]);
    }

    checkOut(id, stationName, t) {
        const [startStation, startTime] = this.checkIns.get(id);
        const travelKey = `${startStation}-${stationName}`;
        const travelTime = t - startTime;

        if (!this.travelTimes.has(travelKey)) {
            this.travelTimes.set(travelKey, [0, 0]);
        }

        const [totalTime, count] = this.travelTimes.get(travelKey);
        this.travelTimes.set(travelKey, [totalTime + travelTime, count + 1]);
        this.checkIns.delete(id);
    }

    getAverageTime(startStation, endStation) {
        const [totalTime, count] = this.travelTimes.get(`${startStation}-${endStation}`);
        return totalTime / count;
    }
}