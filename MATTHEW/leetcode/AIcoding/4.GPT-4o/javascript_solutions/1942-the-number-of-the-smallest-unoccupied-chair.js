function smallestChair(times, targetFriend) {
    const events = [];
    for (let i = 0; i < times.length; i++) {
        events.push([times[i][0], i]); // Arrival
        events.push([times[i][1], -i]); // Departure
    }
    events.sort((a, b) => a[0] - b[0] || a[1] - b[1]);

    const chairs = [];
    const occupied = new Set();
    for (let [time, id] of events) {
        if (id >= 0) {
            let chair = 0;
            while (occupied.has(chair)) chair++;
            chairs[id] = chair;
            occupied.add(chair);
        } else {
            occupied.delete(chairs[-id]);
        }
    }
    return chairs[targetFriend];
}