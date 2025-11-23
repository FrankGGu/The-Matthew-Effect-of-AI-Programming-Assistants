function haveConflict(event1, event2) {
    const timeToMinutes = (time) => {
        const [hours, minutes] = time.split(':').map(Number);
        return hours * 60 + minutes;
    };

    const start1 = timeToMinutes(event1[0]);
    const end1 = timeToMinutes(event1[1]);
    const start2 = timeToMinutes(event2[0]);
    const end2 = timeToMinutes(event2[1]);

    return !(end1 < start2 || end2 < start1);
}