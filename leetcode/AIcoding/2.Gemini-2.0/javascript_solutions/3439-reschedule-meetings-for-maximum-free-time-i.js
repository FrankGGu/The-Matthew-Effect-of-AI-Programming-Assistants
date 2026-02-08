var meetingPlanner = function(meetings) {
    meetings.sort((a, b) => a[0] - b[0]);
    const freeTime = [];
    for (let i = 1; i < meetings.length; i++) {
        if (meetings[i][0] > meetings[i - 1][1]) {
            freeTime.push([meetings[i - 1][1], meetings[i][0]]);
        }
    }
    return freeTime;
};