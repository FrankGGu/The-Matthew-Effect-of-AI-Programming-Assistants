var UndergroundSystem = function() {
    this.checkIns = new Map();
    this.travelTimes = new Map();
};

UndergroundSystem.prototype.checkIn = function(id, stationName, t) {
    this.checkIns.set(id, { stationName, t });
};

UndergroundSystem.prototype.checkOut = function(id, stationName, t) {
    const checkIn = this.checkIns.get(id);
    this.checkIns.delete(id);
    const startStation = checkIn.stationName;
    const startTime = checkIn.t;
    const route = `${startStation}->${stationName}`;

    if (!this.travelTimes.has(route)) {
        this.travelTimes.set(route, { totalTime: 0, count: 0 });
    }

    const routeData = this.travelTimes.get(route);
    routeData.totalTime += (t - startTime);
    routeData.count++;
};

UndergroundSystem.prototype.getAverageTime = function(startStation, endStation) {
    const route = `${startStation}->${endStation}`;
    const routeData = this.travelTimes.get(route);
    return routeData.totalTime / routeData.count;
};