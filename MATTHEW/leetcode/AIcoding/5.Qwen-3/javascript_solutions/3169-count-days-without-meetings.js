function countDaysWithoutMeetings(days, meetings) {
    const set = new Set();
    for (const [start, end] of meetings) {
        for (let i = start; i <= end; i++) {
            set.add(i);
        }
    }
    return days - set.size;
}