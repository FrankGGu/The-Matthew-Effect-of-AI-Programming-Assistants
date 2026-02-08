var canVisitAllRooms = function(rooms) {
    const visited = new Set();
    const stack = [0];

    while (stack.length) {
        const room = stack.pop();
        if (!visited.has(room)) {
            visited.add(room);
            for (const key of rooms[room]) {
                if (!visited.has(key)) {
                    stack.push(key);
                }
            }
        }
    }

    return visited.size === rooms.length;
};