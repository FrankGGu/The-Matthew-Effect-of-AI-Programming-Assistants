function maxFreeTime(meetings) {
    meetings.sort((a, b) => a[0] - b[0]);
    const freeTimes = [];

    let end = meetings[0][1];
    for (let i = 1; i < meetings.length; i++) {
        if (meetings[i][0] > end) {
            freeTimes.push([end, meetings[i][0]]);
        }
        end = Math.max(end, meetings[i][1]);
    }

    return freeTimes;
}