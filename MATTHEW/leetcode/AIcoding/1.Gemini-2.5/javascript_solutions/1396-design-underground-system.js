var UndergroundSystem = function() {
    this.checkIns = new Map(); // customerId -> { stationName, time }
    this.tripTimes = new Map(); // "startStation-endStation" -> { totalTime, count }
};

UndergroundSystem.prototype.checkIn = function(id, stationName, t) {
    this.checkIns.set(id, { stationName: stationName, time: t });
};

UndergroundSystem.prototype.checkOut = function(id, stationName, t) {
    const checkInInfo = this.checkIns.get(id);
    const startStation = checkInInfo.stationName;
    const startTime = checkInInfo.time;

    const routeKey = `${startStation}-${stationName}`;
    const tripDuration = t - startTime;

    if (!this.tripTimes.has(routeKey)) {
        this.tripTimes.set(routeKey, { totalTime: 0, count: 0 });
    }

    const routeData = this.tripTimes.get(routeKey);
    routeData.totalTime += tripDuration;
    routeData.count++;

    this.checkIns.delete(id); // Customer has checked out, clear their check-in info
};

UndergroundSystem.prototype.getAverageTime = function(startStation, endStation) {
    const routeKey = `${startStation}-${endStation}`;
    const routeData = this.tripTimes.get(routeKey);

    return routeData.totalTime / routeData.count;
};