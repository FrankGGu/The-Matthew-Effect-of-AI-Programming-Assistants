var minMeetingRooms = function(times) {
    const arrivals = [];
    const departures = [];

    for (const [arrival, departure] of times) {
        arrivals.push(arrival);
        departures.push(departure);
    }

    arrivals.sort((a, b) => a - b);
    departures.sort((a, b) => a - b);

    let rooms = 0;
    let arrivalIndex = 0;
    let departureIndex = 0;
    let maxRooms = 0;

    while (arrivalIndex < times.length) {
        if (arrivals[arrivalIndex] < departures[departureIndex]) {
            rooms++;
            arrivalIndex++;
        } else {
            rooms--;
            departureIndex++;
        }
        maxRooms = Math.max(maxRooms, rooms);
    }

    return maxRooms;
};