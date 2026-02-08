var minRefuelStops = function(target, startFuel, stations) {
    stations.sort((a, b) => a[0] - b[0]);
    let n = stations.length;
    let pq = [];
    let i = 0;
    let stops = 0;
    let currentFuel = startFuel;

    while (currentFuel < target) {
        while (i < n && stations[i][0] <= currentFuel) {
            pq.push(stations[i][1]);
            i++;
        }

        if (pq.length === 0) {
            return -1;
        }

        pq.sort((a, b) => b - a);
        currentFuel += pq.shift();
        stops++;
    }

    return stops;
};