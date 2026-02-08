function canCompleteTrainingPlan(neededTraining, trainingDays) {
    let totalTraining = 0;
    for (let i = 0; i < trainingDays.length; i++) {
        totalTraining += trainingDays[i];
    }
    return totalTraining >= neededTraining;
}