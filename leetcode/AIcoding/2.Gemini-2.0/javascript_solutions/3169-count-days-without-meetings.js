var countDaysWithoutMeetings = function(n, meetings) {
    meetings.sort((a, b) => a - b);
    let lastDay = 0;
    for (let i = 0; i < meetings.length; i++) {
        lastDay = Math.max(lastDay + 1, meetings[i]);
    }
    return n - lastDay;
};