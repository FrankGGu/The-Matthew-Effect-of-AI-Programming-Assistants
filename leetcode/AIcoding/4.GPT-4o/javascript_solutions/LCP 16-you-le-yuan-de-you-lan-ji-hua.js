var canVisitAllRooms = function(rooms) {
    const visited = new Set();
    const stack = [0];

    while (stack.length > 0) {
        const room = stack.pop();
        if (!visited.has(room)) {
            visited.add(room);
            for (const key of rooms[room]) {
                stack.push(key);
            }
        }
    }

    return visited.size === rooms.length;
};