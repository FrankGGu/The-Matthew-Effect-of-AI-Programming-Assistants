var countDaysWithoutMeetings = function(days, meetings) {
    if (meetings.length === 0) {
        return days;
    }

    meetings.sort((a, b) => a[0] - b[0]);

    let mergedIntervals = [];
    mergedIntervals.push(meetings[0]);

    for (let i = 1; i < meetings.length; i++) {
        let currentMeeting = meetings[i];
        let lastMerged = mergedIntervals[mergedIntervals.length - 1];

        if (currentMeeting[0] <= lastMerged[1] + 1) { // +1 to account for adjacent meetings like [1,2] and [3,4]
            lastMerged[1] = Math.max(lastMerged[1], currentMeeting[1]);
        } else {
            mergedIntervals.push(currentMeeting);
        }
    }

    let totalMeetingDays = 0;
    for (let i = 0; i < mergedIntervals.length; i++) {
        let start = mergedIntervals[i][0];
        let end = mergedIntervals[i][1];
        totalMeetingDays += (end - start + 1);
    }

    return days - totalMeetingDays;
};