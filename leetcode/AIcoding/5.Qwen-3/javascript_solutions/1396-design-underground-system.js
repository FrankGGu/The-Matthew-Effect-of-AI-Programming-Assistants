var UndergroundSystem = function() {
    this.checkInMap = new Map();
    this.travelTimeMap = new Map();
};

UndergroundSystem.prototype.checkIn = function(userId, stationName, t) {
    this.checkInMap.set(userId, { station: stationName, time: t });
};

UndergroundSystem.prototype.checkOut = function(userId, stationName, t) {
    const checkIn = this.checkInMap.get(userId);
    const key = `${checkIn.station}-${stationName}`;
    const duration = t - checkIn.time;

    if (!this.travelTimeMap.has(key)) {
        this.travelTimeMap.set(key, { total: 0, count: 0 });
    }

    const data = this.travelTimeMap.get(key);
    data.total += duration;
    data.count += 1;
    this.checkInMap.delete(userId);
};

UndergroundSystem.prototype.getAverageTime = function(startStation, endStation) {
    const key = `${startStation}-${endStation}`;
    const data = this.travelTimeMap.get(key);
    return data.total / data.count;
};