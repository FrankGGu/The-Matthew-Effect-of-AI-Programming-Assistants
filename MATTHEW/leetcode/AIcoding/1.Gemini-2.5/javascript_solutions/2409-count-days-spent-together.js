var countDaysTogether = function(aliceArrivalDeparture, bobArrivalDeparture) {
    const daysInMonthPrefixSum = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];

    const dateToDayOfYear = (dateStr) => {
        const [month, day] = dateStr.split('-').map(Number);
        return daysInMonthPrefixSum[month - 1] + day;
    };

    const aliceArrivalDay = dateToDayOfYear(aliceArrivalDeparture[0]);
    const aliceDepartureDay = dateToDayOfYear(aliceArrivalDeparture[1]);

    const bobArrivalDay = dateToDayOfYear(bobArrivalDeparture[0]);
    const bobDepartureDay = dateToDayOfYear(bobArrivalDeparture[1]);

    const overlapStart = Math.max(aliceArrivalDay, bobArrivalDay);
    const overlapEnd = Math.min(aliceDepartureDay, bobDepartureDay);

    return Math.max(0, overlapEnd - overlapStart + 1);
};