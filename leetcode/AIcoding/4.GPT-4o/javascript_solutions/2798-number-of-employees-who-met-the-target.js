var numberOfEmployeesWhoMetTarget = function(hours, target) {
    return hours.filter(hour => hour >= target).length;
};