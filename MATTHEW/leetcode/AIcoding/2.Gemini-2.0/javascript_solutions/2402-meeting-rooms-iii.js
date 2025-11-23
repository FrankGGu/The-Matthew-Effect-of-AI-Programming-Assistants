var mostBooked = function(n, meetings) {
    meetings.sort((a, b) => a[0] - b[0]);
    const rooms = new Array(n).fill(0);
    const available = new Array(n).fill(0);

    for (const meeting of meetings) {
        const start = meeting[0];
        const end = meeting[1];
        let found = false;

        for (let i = 0; i < n; i++) {
            if (available[i] <= start) {
                rooms[i]++;
                available[i] = end;
                found = true;
                break;
            }
        }

        if (!found) {
            let minAvailableTime = Infinity;
            let minAvailableIndex = -1;
            for (let i = 0; i < n; i++) {
                if (available[i] < minAvailableTime) {
                    minAvailableTime = available[i];
                    minAvailableIndex = i;
                }
            }
            rooms[minAvailableIndex]++;
            available[minAvailableIndex] += (end - start);
        }
    }

    let maxMeetings = 0;
    let maxMeetingsIndex = 0;
    for (let i = 0; i < n; i++) {
        if (rooms[i] > maxMeetings) {
            maxMeetings = rooms[i];
            maxMeetingsIndex = i;
        }
    }

    return maxMeetingsIndex;
};