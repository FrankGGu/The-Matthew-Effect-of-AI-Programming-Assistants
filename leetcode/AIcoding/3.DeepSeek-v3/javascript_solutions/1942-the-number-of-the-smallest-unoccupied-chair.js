var smallestChair = function(times, targetFriend) {
    const n = times.length;
    const arrival = times[targetFriend][0];
    const people = [];
    for (let i = 0; i < n; i++) {
        people.push({
            arrive: times[i][0],
            leave: times[i][1],
            index: i
        });
    }
    people.sort((a, b) => a.arrive - b.arrive);

    const available = new MinPriorityQueue();
    for (let i = 0; i < n; i++) {
        available.enqueue(i);
    }

    const occupied = new MinPriorityQueue({
        priority: (item) => item.leave
    });

    for (const person of people) {
        const currentTime = person.arrive;
        while (!occupied.isEmpty() && occupied.front().priority <= currentTime) {
            const freedChair = occupied.dequeue().element.chair;
            available.enqueue(freedChair);
        }
        const chair = available.dequeue().element;
        if (person.index === targetFriend) {
            return chair;
        }
        occupied.enqueue({
            chair: chair,
            leave: person.leave
        });
    }
    return -1;
};