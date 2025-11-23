var minRefuelStops = function(target, startFuel, stations) {
    const maxHeap = new MaxPriorityQueue();
    let stops = 0;
    let currentFuel = startFuel;
    let i = 0;

    while (currentFuel < target) {
        while (i < stations.length && stations[i][0] <= currentFuel) {
            maxHeap.enqueue(stations[i][1]);
            i++;
        }

        if (maxHeap.isEmpty()) {
            return -1;
        }

        currentFuel += maxHeap.dequeue().element;
        stops++;
    }

    return stops;
};