var smallestChair = function(friends, targetFriend) {
    const arrivals = friends.map((friend, index) => [friend[0], friend[1], index]);
    arrivals.sort((a, b) => a[0] - b[0]);

    const occupied = new Map();
    const available = [];

    for (let i = 0; i < arrivals.length; i++) {
        const [arrival, departure, friendIndex] = arrivals[i];

        while (available.length > 0 && available[0][0] <= arrival) {
            const [depTime, chair] = available.shift();
            occupied.delete(chair);
        }

        let chair;
        if (occupied.size === 0) {
            chair = 0;
        } else {
            let minChair = 0;
            while (occupied.has(minChair)) {
                minChair++;
            }
            chair = minChair;
        }

        occupied.set(chair, friendIndex);
        if (friendIndex === targetFriend) {
            return chair;
        }

        let j = i + 1;
        while(j < arrivals.length && arrivals[j][0] === arrival) {
            j++;
        }

        available.push([departure, chair]);
        available.sort((a, b) => a[0] - b[0]);

    }

    return -1;
};