class UndergroundSystem {
    constructor() {
        this.checkIns = new Map();
        this.travelTimes = new Map();
    }

    checkIn(id, stationName, t) {
        this.checkIns.set(id, { stationName, t });
    }

    checkOut(id, stationName, t) {
        const checkInData = this.checkIns.get(id);
        const route = `${checkInData.stationName}-${stationName}`;
        const travelTime = t - checkInData.t;

        if (!this.travelTimes.has(route)) {
            this.travelTimes.set(route, { totalTime: 0, count: 0 });
        }
        const routeData = this.travelTimes.get(route);
        routeData.totalTime += travelTime;
        routeData.count += 1;

        this.checkIns.delete(id);
    }

    getAverageTime(startStation, endStation) {
        const route = `${startStation}-${endStation}`;
        const routeData = this.travelTimes.get(route);
        return routeData.totalTime / routeData.count;
    }
}