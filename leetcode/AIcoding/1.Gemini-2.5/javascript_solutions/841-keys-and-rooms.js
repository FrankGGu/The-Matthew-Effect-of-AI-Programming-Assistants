var canVisitAllRooms = function(rooms) {
    const n = rooms.length;
    const visited = new Set();
    const queue = [0];
    visited.add(0);

    while (queue.length > 0) {
        const currentRoom = queue.shift();

        for (const key of rooms[currentRoom]) {
            if (!visited.has(key)) {
                visited.add(key);
                queue.push(key);
            }
        }
    }

    return visited.size === n;
};